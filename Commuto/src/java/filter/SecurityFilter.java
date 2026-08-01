package filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "SecurityFilter", urlPatterns = {"/*"})
public class SecurityFilter implements Filter {

    private static final Set<String> PUBLIC_PATHS = new HashSet<>(Arrays.asList(
            "/index.jsp", "/login.jsp", "/register.jsp",
            "/LoginServlet", "/RegisterServlet",
            "/css/", "/js/", "/images/", "/assets/", "/WEB-INF/"
    ));

    private static final Set<String> CSRF_PROTECTED = new HashSet<>(Arrays.asList(
            "/BookRideServlet", "/RideRequestServlet",
            "/AcceptRideServlet", "/RejectRideServlet", "/AddRideServlet"
    ));

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String path = httpRequest.getRequestURI()
                .substring(httpRequest.getContextPath().length());

        HttpSession session = httpRequest.getSession(false);
        boolean loggedIn = session != null
                && session.getAttribute("currentUser") != null;

        if ("POST".equalsIgnoreCase(httpRequest.getMethod())
                && CSRF_PROTECTED.contains(path)) {

            String expected = session == null
                    ? null : (String) session.getAttribute("csrfToken");
            String actual = httpRequest.getParameter("csrfToken");

            if (expected == null || !expected.equals(actual)) {
                httpResponse.sendRedirect("login.jsp?error=csrf");
                return;
            }
        }

        if (!isPublic(path) && !loggedIn) {
            httpResponse.sendRedirect("login.jsp?error=auth");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublic(String path) {
        if (path.isEmpty() || path.equals("/")) {
            return true;
        }
        for (String prefix : PUBLIC_PATHS) {
            if (path.startsWith(prefix)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void destroy() {
    }
}
