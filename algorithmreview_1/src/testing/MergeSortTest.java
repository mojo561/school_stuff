package testing;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;

import org.junit.jupiter.api.Test;

import mergesort.MergeSort;
import mergesort.Node;

class MergeSortTest {

	@Test
	void testSort()
	{
		for(int j = 0; j < 1000; ++j)
		{
			ArrayList<Node> unsortedTest = new ArrayList<Node>();
			for(int i = 0; i < 100; ++i)
			{
				unsortedTest.add(new Node());
			}
			
			ArrayList<Node> sortedTest = MergeSort.sort(unsortedTest);
			
			for(int i = 0; i < sortedTest.size() - 1; ++i)
			{
				assertTrue(sortedTest.get(i).compareTo(sortedTest.get(i + 1)) <= 0);
			}
		}
	}

}
