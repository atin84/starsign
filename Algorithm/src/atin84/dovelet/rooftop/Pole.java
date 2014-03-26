package atin84.dovelet.rooftop;
import java.util.Scanner;
import java.util.Vector;

/**
 * 일직선상에 N 개의 전봇대가 한 줄로 서있다. 편의상, 일직선을 x-축이라 하고, 전봇대가 서 있는 위치 x0,x1,...,xN-1 은 x-축 상의 x-좌표라고 하자. x0는 항상 0이고 xi(i ≥ 1)는 양의 정수라고 가정한다
 * 이 전봇대들을 이웃한 두 전봇대 사이의 거리가 모두 일정하도록 일부 전봇대들을 옮기려고 한다. 이때 이동해야하는 전봇대들의 거리의 합이 최소가 되도록 해야 한다. 단, x0 에 위치한 전봇대는 움직일 수 없고, 이동하는 전봇대들은 정수 좌표 위치로만 이동 가능하다.
 * 예를 들어, 아래의 그림 1과 같이 전봇대가 주어져 있다고 하자.
 * 이 경우 그림 2에서와 같이 x-좌표 6과 9에 위치한 전봇대를 각각 x-좌표 8과 12인 곳으로 이동하면, 모든 이웃한 전봇대들의 거리는 4로 같고 전봇대의 이동 거리의 합은 5이다.
 * 하지만 그림 3과 같이 x-좌표 4에 위치한 전봇 대만을 x-좌표 3인 곳으로 이동하면, 이웃한 전 봇대들의 거리는 모두 3이고 전봇대의 이동 거리의 합은 1이다.
 * 전봇대들의 위치 x0,x1,x2, .. , xN-1 이 주어지면, 모든 이웃한 전봇대들의 거리가 같도록 전봇대들을 이동할 때(x0 에 위치한 전봇대는 고정), 이동 거리의 합이 최소가 되도록 하는 프로그램을 작성 하시오.
 * 수행시간은 1초를 넘을 수 없다.
 * 입력
 * 입력의 첫 줄은 전봇대의 수 N ( 1 ≤ N ≤ 100,000 )이 주어진다.
 * 두 번째 줄에는 전봇대의 위치를 나타내는 N 개의 서로 다른 x-좌표 xi (i = 0 , ... , N-1)가 빈칸을 사이에 두고 오름차순으로 주어진다. xi는 정수이고, 0 ≤ xi ≤ 1 000 000 000.
 * 출력
 * 출력은 단 한 줄이며, 모든 이웃한 전봇대들의 거리가 같도록 전봇대들의 이동거리 합의 최솟값을 출력한다.
 * 중간 계산 결과와 출력할 값이 32비트 정수형 범위를 벗어날 수 있으니 64비트 정수형을 이용 할 것을 권장한다.
 * 입출력 예
 * 입력
 * 4
 * 0 4 6 9
 * 출력
 * 1
 * 입력
 * 7
 * 0 5 12 15 16 22 23
 * 출력
 * 11
 * @author Chang-Hwan Han
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