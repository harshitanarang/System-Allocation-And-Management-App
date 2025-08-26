import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DBConfig {
    private static String url;
    private static String user;
    private static String pass;

    static {
        try (InputStream input = DBConfig.class.getClassLoader().getResourceAsStream("config.properties")) {
            Properties props = new Properties();
            if (input == null) {
                throw new RuntimeException("config.properties not found in resources!");
            }
            props.load(input);

            url = props.getProperty("DB_URL");
            user = props.getProperty("DB_USER");
            pass = props.getProperty("DB_PASS");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getUrl() {
        return url;
    }
    public static String getUser() {
        return user;
    }
    public static String getPass() {
        return pass;
    }
}
