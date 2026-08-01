package util;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class PasswordUtilTest {

    @Test
    public void hashProducesStorableValue() {
        String hash = PasswordUtil.hash("secret123");
        assertNotNull(hash);
        assertTrue(hash.split(":").length == 3);
    }

    @Test
    public void verifyMatchesCorrectPassword() {
        String password = "CorrectHorse99";
        String hash = PasswordUtil.hash(password);
        assertTrue(PasswordUtil.verify(password, hash));
    }

    @Test
    public void verifyRejectsWrongPassword() {
        String hash = PasswordUtil.hash("right-password");
        assertFalse(PasswordUtil.verify("wrong-password", hash));
    }

    @Test
    public void verifyRejectsNullOrMalformedInput() {
        assertFalse(PasswordUtil.verify(null, "anything"));
        assertFalse(PasswordUtil.verify("password", null));
        assertFalse(PasswordUtil.verify("password", "malformed"));
    }

    @Test
    public void hashesAreSaltedAndUnique() {
        String a = PasswordUtil.hash("same-password");
        String b = PasswordUtil.hash("same-password");
        assertNotEquals(a, b);
        assertTrue(PasswordUtil.verify("same-password", a));
        assertTrue(PasswordUtil.verify("same-password", b));
    }
}
