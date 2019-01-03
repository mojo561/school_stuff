package mergesort;

import java.util.ArrayList;

public class MergeSort
{
	public static <T extends Comparable<T>> ArrayList<T> sort(ArrayList<T> s)
	{
		int s1length = s.size();
		if(s1length <= 1)
		{
			return s;
		}
		ArrayList<T> s1 = new ArrayList<T>();
		ArrayList<T> s2 = new ArrayList<T>();
		int i = 0;
		for(; i < s1length / 2; ++i)
		{
			s1.add(s.get(i));
		}
		for(; i < s1length; ++i)
		{
			s2.add(s.get(i));
		}
		s1 = sort(s1);
		s2 = sort(s2);
		return mergeSort(s1, s2);
	}
	
	private static <T extends Comparable<T>> ArrayList<T> mergeSort(ArrayList<T> s1, ArrayList<T> s2)
	{
		ArrayList<T> s = new ArrayList<T>();
		while(!(s1.isEmpty() || s2.isEmpty()))
		{
			if(s1.get(0).compareTo(s2.get(0)) <= 0)
			{
				s.add(s1.remove(0));
			}
			else
			{
				s.add(s2.remove(0));
			}
		}
		while(!s1.isEmpty())
		{
			s.add(s1.remove(0));
		}
		while(!s2.isEmpty())
		{
			s.add(s2.remove(0));
		}
		return s;
	}
}