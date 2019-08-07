package myproject;

import org.testng.annotations.Test;
import org.testng.AssertJUnit;

public class additiontest {
	@Test
	public void testAdd() {
	AssertJUnit.assertEquals(3, addition.add(1, 2));
	}
	public void testDiv() {
		 AssertJUnit.assertEquals(1, addition.div(3, 2));
		 }
		 }


