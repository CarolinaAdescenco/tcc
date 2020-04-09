package services;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.xml.bind.DatatypeConverter;


public class PasswordService {

    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
        messageDigest.update(password.getBytes());

        byte[] digiest = messageDigest.digest();
        return DatatypeConverter.printHexBinary(digiest);
    }
}
