package atin84.dovelet.rooftop;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Scanner;
import java.util.Vector;

/**
 * koi_aio
 * 아시아 정보올림피아드
 * http://183.106.113.109/pool/koi_aio/koi_aio.php?pname=koi_aio
 * @author atin84
 *
 */
public class Aio {

	private HashMap<Integer, Integer> peopleMap = new HashMap<Integer, Integer>();
	
	public void caculate(int n, Vector<People> p, int lastNation) {
		Collections.sort(p, new PeopleComparator());
		int count = 0;
		for(int i = 0; i < 3; ) {
			People people = getMax(p);
			
			if(peopleMap.containsKey(people.getNation())) {
				count = peopleMap.get(people.getNation());
			} else {
				count = 0;
			}
			count++;
			peopleMap.put(people.getNation(), count);
			if(count < 3) {
				System.out.println(people);
				i++;
			}
		}
	}
	
	private People getMax(Vector<People> p) {
		People top = new People();
		for(int i = 0; i < p.size(); i++) {
			People people = p.get(i);
			top = top.getScore() > people.getScore() ? top : people;
		}
		p.remove(top);
		return top;
	}

	public static void main(String[] args) throws Exception {
		Scanner sc = new Scanner(System.in);
		int n = Integer.parseInt(sc.nextLine());
		
		if(n < 3 || n > 100) {
			System.out.println("wrong input");
			System.exit(1);
		}
		
		Vector<People> p = new Vector<People>(n, 0);
		int lastNation = 0;
		for(int i = 0; i < n; i++) {
			People people = new People();
			lastNation = sc.nextInt();
			people.setNation(lastNation);
			people.setIdx(sc.nextInt());
			people.setScore(sc.nextInt());
			p.add(people);
		}
		new Aio().caculate(n, p, lastNation);

	}
}

class People {
	private int nation;
	private int idx;
	private int score;
	
	public int getNation() {
		return nation;
	}
	public void setNation(int nation) {
		this.nation = nation;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	@Override
	public String toString() {
		return nation + " " + idx;
	}
}

class PeopleComparator implements Comparator<People> {
	@Override
	public int compare(People o1, People o2) {
		return o1.getScore() > o2.getScore() ? 0 : 1;
	}	
}