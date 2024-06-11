package himedia.dao;

import java.util.List;

public interface GuestBookDao {
	public List<GuestVo> getList();
	public boolean insert(GuestVo vo);
	public boolean delete(Long no);
}
