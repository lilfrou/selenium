package mysecondproject;

import org.testng.annotations.Test;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

public class test2 {
	WebDriver driver= null;
	@BeforeTest
	public void setuptest(){
		
		System.setProperty("webdriver.chrome.driver", "/var/lib/jenkins/workspace/chromedriver");
		ChromeOptions options = new ChromeOptions();
		options.setBinary("/etc/alternatives/google-chrome");
		options.setHeadless(true);
		 driver = new ChromeDriver(options);
		 System.out.println("testing started");
		
		
	}
	
	@Test
	public void thetest() {
		driver.get("http://demo.guru99.com/test/ajax.html");
	    List<WebElement> elements = driver.findElements(By.name("name"));
	   
	    System.out.println("Number of elements:" +elements.size());

	    for (int i=0; i<elements.size();i++){
	      System.out.println("Radio button text:" + elements.get(i).getAttribute("value"));
	    }
		
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("testing complet");
	}
			@AfterTest	
		public void killtest() {
			driver.close();
			System.out.println("testing finished succefely");
		
		}
}
