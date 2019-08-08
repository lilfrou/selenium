package mysecondproject;

import org.testng.annotations.Test;
import org.testng.AssertJUnit;
import org.testng.AssertJUnit;
import org.testng.annotations.Test;



public class addition2test2 {
	@Test
	public void testAdd() {
	AssertJUnit.assertEquals(3, addition2.add2(1, 2));
	System.out.println("testadd");
	}
	@Test
	public void testDiv() {
		 AssertJUnit.assertEquals(1, addition2.div2(3, 2));
		 System.out.println("testdiv");
		 }
}
