package guestbook;

import java.util.List;

public interface GuestBookDAO {

	List<GuestBookVO> getList();
	GuestBookVO get(Long no);
	boolean insert(GuestBookVO vo);
	boolean delete(GuestBookVO vo);
}