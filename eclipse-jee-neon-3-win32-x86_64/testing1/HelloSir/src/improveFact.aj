
public aspect improveFact {
	
	after()returning(long result):call(long Math.fact(int))&&!cflowbelow(call (long Math.fact(int))){
		System.out.println("result "+result);
	}
	before(int x):execution(long Math.fact(int)) && args(x){
		System.out.println("fact "+x);
	}
	pointcut reuse(): execution (long Math.fact(int));
	int around(): call(long Math.fact(int)){
		proceed();
		return 1;
	}
	
}
