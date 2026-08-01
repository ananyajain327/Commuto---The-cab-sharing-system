package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordUtil {

    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";
    private static final int ITERATIONS = 120_000;
    private static final int KEY_LENGTH = 256;
    private static final int SALT_BYTES = 16;

    private PasswordUtil() {
    }

    public static String hash(String password) {
        try {
            byte[] salt = new byte[SALT_BYTES];
            new SecureRandom().nextBytes(salt);

            byte[] hash = pbkdf2(password.toCharArray(), salt, ITERATIONS);

            return ITERATIONS + ":" + toBase64(salt) + ":" + toBase64(hash);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            throw new IllegalStateException("Password hashing failed", ex);
        }
    }

    public static boolean verify(String password, String stored) {
        if (password == null || stored == null) {
            return false;
        }

        try {
            String[] parts = stored.split(":");
            if (parts.length != 3) {
                return false;
            }

            int iterations = Integer.parseInt(parts[0]);
            byte[] salt = fromBase64(parts[1]);
            byte[] expected = fromBase64(parts[2]);

            byte[] actual = pbkdf2(password.toCharArray(), salt, iterations);

            return MessageDigest.isEqual(expected, actual);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException | RuntimeException ex) {
            return false;
        }
    }

    private static byte[] pbkdf2(char[] password, byte[] salt, int iterations)
            throws NoSuchAlgorithmException, InvalidKeySpecException {

        PBEKeySpec spec = new PBEKeySpec(password, salt, iterations, KEY_LENGTH);
        SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
        return factory.generateSecret(spec).getEncoded();
    }

    private static String toBase64(byte[] data) {
        return Base64.getEncoder().encodeToString(data);
    }

    private static byte[] fromBase64(String data) {
        return Base64.getDecoder().decode(data);
    }
}
