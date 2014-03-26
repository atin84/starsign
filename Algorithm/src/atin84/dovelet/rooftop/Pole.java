package atin84.dovelet.rooftop;
import java.util.Scanner;
import java.util.Vector;

/**
 * koi_pole
 * 전봇대
 * http://183.106.113.109/pool/koi_pole/koi_pole.php?pname=koi_pole
 * @author atin84
 *
 */
public class Pole {

	private static Vector<Integer> p;
	
	@SuppressWarnings("static-access")
	public Pole(Vector<Integer> p) {
		this.p = p;
	}

	/**
	 * 간격의 최대값을 설정한 후에 이진탐색으로 좌우를 비교해값면서 최저값을 찾아감
	 * 
	 * @param n
	 * @return
	 */
	public long jub(int n) {
		if(n < 2) return 0;
		
		long leftVal = 0;
		long rightVal = 0;
		long centerVal = 0;
		
		/**
		 * 최대값의 설정
		 * 전체 값들의 평균을 구한 후에 전봇대의 숫자-1로 나눔
		 * 값이 너무 크면 잘못된 값을 추출할 수 있는 것에 대한 방어 로직
		 */
		long max = 0;
		for(int i = 0; i < n; i++) {
			max += p.get(i);
		}
		max = max / (n-1);
		
		// 이동할 값
		long idx = max / 2;
		
		// 좌우 최대값
		long leftMax = 0;
		long rightMax = max;
		while(true) {
			leftVal = getMoveCount(n, idx -1);
			centerVal= getMoveCount(n, idx);
			rightVal = getMoveCount(n, idx + 1);
			
			/**
			 * 좌우값을 비교하여 비용이 적은 쪽으로 이동한다.
			 */
			if(leftVal < rightVal) {
				// left
				rightMax = idx;
				idx = leftMax + ((rightMax - leftMax) /2);
			} else {
				// right
				leftMax = idx;
				idx = rightMax + ((rightMax - leftMax) /2);
			}
			
			/**
			 * 중단 로직 : 좌우값의 비용보다 가운데 값의 비용이 제일 적다면 최적값을 찾은 것으로 판단
			 */
			if(leftVal > centerVal && rightVal > centerVal) {
				break;
			}
		}
		
		return centerVal;
	}

	/**
	 * p 배열에 n개의 수가 있을 때 duration의 값의 간격이 주어질 경우 이동거리를 구한다.
	 * @param n
	 * @param duration
	 * @return
	 */
	public long getMoveCount(int n, long duration) {		
		long result = 0;
		for(int i = 1; i < n; i++) {
			result += Math.abs((duration * i) - p.get(i));
		}
		return result;
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = Integer.parseInt(sc.nextLine());
		Vector<Integer> p = new Vector<Integer>(n, 0);
		for(int i = 0; i < n; i++) {
			p.add(sc.nextInt());
		}		
		System.out.println(new Pole(p).jub(n));
	}	
}