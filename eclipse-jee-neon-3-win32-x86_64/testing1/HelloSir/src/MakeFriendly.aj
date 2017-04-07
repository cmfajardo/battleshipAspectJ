
public aspect MakeFriendly {
	pointcut SayPoint(): execution (void HelloWorld.say(String));
		
	before(): SayPoint(){
		System.out.println("Hi, Friend");
	}
	
}
