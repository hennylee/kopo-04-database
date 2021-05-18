```java

public static void main(String[] args) {
		ListNode node1 = new ListNode(1);
		
		for(int i= 2; i<=5; i++) {
			node1.next = new ListNode(i);
			node1 = node1.next;
		}
		
		while(node1.next != null) {
			System.out.println(node1.val);
			node1 = node1.next;
		}

	}
  
  ```
