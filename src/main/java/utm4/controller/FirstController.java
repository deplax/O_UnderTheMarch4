package utm4.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import utm4.basic.First;

@Controller
public class FirstController {
	private static final Logger log = LoggerFactory.getLogger(FirstController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String print(){
		log.debug("찍히나요?");
		return "index";
	}
	
	@RequestMapping(value = "/kuku", method = RequestMethod.GET)
	public String print2(){
		
		AbstractApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		First f = (First)context.getBean("kuku");
		System.out.println(f.result("a","b"));
		
		
		return "kuku";
	}
}
