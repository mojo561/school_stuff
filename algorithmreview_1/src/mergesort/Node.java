package mergesort;

import java.util.Random;

public class Node implements Comparable<Node>
{
	private static Random r;
	private int number;
	public Node()
	{
		if(r == null)
		{
			r = new Random(System.currentTimeMillis());
		}
		number = r.nextInt();
	}
	
	public Node(int number)
	{
		this.number = number;
	}

	@Override
	public int compareTo(Node n)
	{
		if(this.number < n.number)
		{
			return -1;
		}
		else if(this.number == n.number)
		{
			return 0;
		}
		return 1;
	}
	
	@Override
	public String toString()
	{
		return String.valueOf(number);
	}
}