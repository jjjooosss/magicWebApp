package test_230515;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Member {
    private int memNo;
    private int memCount;
    private String id;
    private String name;
    private String location;
    
    private static Member instance = new Member();
    private static List<Member> members = new ArrayList<>();
    
    private Member() {
    	
    }

    public int getMemCount() {
        return memCount;
    }

    public void setMemCount(int memCount) {
        this.memCount = memCount;
    }

    public int getMemNo() {
        return memNo;
    }

    public void setMemNo(int memNo) {
        this.memNo = memNo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public static void memberInput() {
        Scanner sc = new Scanner(System.in);

        System.out.println("가입할 회원 수를 입력하세요 >>> ");
        int num = sc.nextInt();
        
        for (int i = 1; i <= num; i++) {
            Member newMember = new Member();
            newMember.setMemCount(num);
            newMember.setMemNo(i);
            System.out.println("회원 정보를 입력하세요.");
            System.out.print("회원 아이디: ");
            newMember.setId(sc.next());
            System.out.print("회원 이름: ");
            newMember.setName(sc.next());
            System.out.print("회원 지역: ");
            newMember.setLocation(sc.next());

            members.add(newMember);
        }
    }
    public static void memberOutput() {
        int count = members.size();
        System.out.println("등록된 회원 수는 " + count + "입니다.");
        for (Member mem : members) {
            System.out.println("회원 번호: " + mem.getMemNo());
            System.out.println("회원 아이디: " + mem.getId());
            System.out.println("회원 이름: " + mem.getName());
            System.out.println("회원 지역: " + mem.getLocation());
            System.out.println("------------------------");
        }
    }

    public static void memberDelete() {
        Scanner sc = new Scanner(System.in);

        System.out.print("삭제할 회원 번호를 입력하세요 >>> ");
        int memNo = sc.nextInt();
        boolean found = false;
        for (Member mem : members) {
            if (mem.getMemNo() == memNo) {
                members.remove(mem);
                found = true;
                break;
            }
        }
        if (found) {
            System.out.println("회원 번호 " + memNo + "의 정보가 삭제되었습니다.");
        } else {
            System.out.println("일치하는 회원 번호를 찾을 수 없습니다.");
        }
    }

    public static void memberManagement() {
        Scanner sc = new Scanner(System.in);
        int num;
        do {
            System.out.println("======= 일반회원 정보관리 ========");
            System.out.println("11. 일반회원 정보입력 | 22. 일반회원 정보삭제 | 33. 일반회원 정보확인 | 0. 이전단계");
            System.out.println("===============================");
            System.out.print("메뉴를 선택하세요 >>> ");
            num = sc.nextInt();

            switch (num) {
                case 11:
                    memberInput();
                    break;
                case 22:
                    memberDelete();
                    break;
                case 33:
                    memberOutput();
                    break;
                case 0:
                    startPage();
                    break;
                default:
                    System.out.println("잘못된 메뉴 선택입니다.");
                    break;
            }
            System.out.println();
        } while (num != 0);
    }

    public static void startPage() {

        Scanner sc = new Scanner(System.in);
        int num;
        while(true) {
        	System.out.println("======= 헬스클럽 회원관리 프로그램 ========");
        	System.out.println("1. 회원정보관리 | 2. 프로그램 종료");
        	System.out.println("=====================================");
        	System.out.print("메뉴를 선택하세요 >>> ");
        	num = sc.nextInt();
        	if (num == 1) {
        		memberManagement();
        		break;
			} else {
				System.out.println("프로그램을 종료합니다.");
				break;
			}  	
        }
        
    }

    public static void main(String[] args) {
        startPage();
    }
}

