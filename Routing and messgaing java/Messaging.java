package Route;

import java.util.concurrent.TimeUnit;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
public class Messaging {

    public static void Message(String message, String phone) throws Exception {
        WebDriver driver = new FirefoxDriver();
            driver.get("http://site5.way2sms.com/content/index.html");
        try {            
            JavascriptExecutor js = (JavascriptExecutor) driver;
            driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
            WebElement element = driver.findElement(By.id("username"));
            element.sendKeys("9999594455");
            element = driver.findElement(By.id("password"));
            element.sendKeys("7978");
            element = driver.findElement(By.id("Login"));
            js.executeScript("arguments[0].click();", element);
            element = wait(driver, "//input[contains(@class,'but reds1 flt skip')]", 2);
            js.executeScript("arguments[0].click();", element);
            element = wait(driver, "//div[contains(@class,'boo I4')]", 2);
            js.executeScript("arguments[0].click();", element);
            element = wait(driver, "//a[contains(@class,'close')]", 2);
            try {
                Thread.sleep(700);
            } catch (Exception e) {
            }
            element = wait(driver, "quicksms", 0);
            js.executeScript("arguments[0].click();", element);
            driver = driver.switchTo().frame("frame");
            element = wait(driver, "//input[contains(@placeholder,'Mobile Number')]", 2);
            element.sendKeys(phone);
            js.executeScript("arguments[0].click();", element);
            element = driver.findElement(By.id("textArea"));
            element.sendKeys(message);
            element = driver.findElement(By.id("Send"));
            js.executeScript("arguments[0].click();", element);
            driver.close();
            driver.quit();
        } catch (Exception e) {
        driver.close();
            driver.quit();
        }
    }

    public static WebElement wait(WebDriver driver, String str, int choice) throws Exception {
        WebElement element = null;
        while (true) {
            try {
                if (choice == 0) {
                    element = driver.findElement(By.id(str));
                } else if (choice == 1) {
                    element = driver.findElement(By.name(str));
                } else if (choice == 2) {
                    element = driver.findElement(By.xpath(str));
                }
                System.out.println(element.getText());
                break;
            } catch (org.openqa.selenium.NoSuchElementException e) {
                System.out.println("Waiting... = " + str);
                Thread.sleep(1000);
            }
        }
        return element;
    }
}
