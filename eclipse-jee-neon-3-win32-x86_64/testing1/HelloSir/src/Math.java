
public class Math {
	public static long fact(int x){
		return x<1?1:x*fact(x-1);
	}
	public static void main(String[] args) {
		fact(10);
	}
}


