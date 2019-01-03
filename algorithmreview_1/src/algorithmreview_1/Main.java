package algorithmreview_1;

import java.util.ArrayList;

import mergesort.MergeSort;
import mergesort.Node;

public class Main
{
	public static void main(String[] args)
	{
		System.out.println("-----------\nMerge sort\n-----------");
		ArrayList<Node> unsorted = new ArrayList<Node>();
		for(int i = 0; i < 10; ++i)
		{
			unsorted.add(new Node());
		}
		
		ArrayList<Node> sorted = MergeSort.sort(unsorted);
		System.out.println(String.format("unsorted: %s", unsorted));
		System.out.println(String.format("sorted: %s", sorted));
	}
}