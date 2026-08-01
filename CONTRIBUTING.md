# 🤝 Contributing to Commuto

Thanks for your interest in improving **Commuto**! Every contribution — a bug report, a feature suggestion, or a pull request — is highly appreciated.

## 🐛 Reporting Issues

1. Search the [existing issues](https://github.com/ananyajain327/Commuto---The-cab-sharing-system/issues) first.
2. If not found, [open a new issue](https://github.com/ananyajain327/Commuto---The-cab-sharing-system/issues/new) and include:
   - A clear title and description
   - Steps to reproduce the bug
   - Expected vs. actual behaviour
   - Screenshots, if applicable

## 🔀 Pull Request Workflow

1. **Fork** the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes and commit them with a clear message:
   ```bash
   git commit -m "feat: add your feature"
   ```
4. Push to your fork and open a **Pull Request** against the `main` branch.
5. Link your PR to any related issue.

## ✅ Code Style

- Follow the existing MVC structure (`controller` → `dao` → `model`).
- Use meaningful class, method and variable names.
- Always use **PreparedStatement** for SQL queries (never string concatenation).
- Keep JSP files free of business logic — route logic through servlets.
- Test your changes locally before submitting.

## 📝 Commit Convention

| Prefix    | Purpose                        |
|-----------|--------------------------------|
| `feat:`   | New feature                    |
| `fix:`    | Bug fix                        |
| `docs:`   | Documentation only             |
| `style:`  | Code style / formatting        |
| `refactor`| Code change without behavior change |
| `chore:`  | Maintenance tasks              |

---

Thank you for helping make **Commuto** better! 🚕
