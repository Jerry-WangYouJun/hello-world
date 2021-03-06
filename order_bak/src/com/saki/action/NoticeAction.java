package com.saki.action;

import java.io.IOException;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TNotice;
import com.saki.service.NoticeServiceI;

@Namespace("/")
@Action(value="notice")
public class NoticeAction extends BaseAction implements ModelDriven<TNotice>{

	private TNotice notice = new TNotice();
	private NoticeServiceI noticeService;
	public NoticeServiceI getNoticeService() {
		return noticeService;
	}
	@Autowired
	public void setNoticeService(NoticeServiceI noticeService) {
		this.noticeService = noticeService;
	}
	@Override
	public TNotice getModel() {
		return notice;
	}
	public void loadAll(){
		super.writeJson(noticeService.list());
	}
	
	public void add(){
		Message j = new Message();
		try{
			noticeService.save(notice);
			updateSessionNotice();
			j.setSuccess(true);
			j.setMsg("添加成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("添加失败");
		}
		super.writeJson(j);
	}
	
	public void update(){
		Message j = new Message();
		try{
			noticeService.update(notice);
			updateSessionNotice();
			j.setSuccess(true);
			j.setMsg("修改成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("操作失败，请联系管理员");
		}
		super.writeJson(j);
	}
	public void delete(){
		Message j = new Message();
		try{
			noticeService.delete(notice.getId());
			updateSessionNotice();
			j.setSuccess(true);
			j.setMsg("删除成功");
		}catch(Exception e){
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("删除失败");
		}
		super.writeJson(j);
		
	}
	
	public void updateSessionNotice() {
		List<TNotice> notice = noticeService.list();
		getSession().setAttribute("notice", notice);
	}
	
	public void writeJson(Object object){
		try {
			String json = JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss");
			ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
			ServletActionContext.getResponse().getWriter().write(json);
			ServletActionContext.getResponse().getWriter().flush();
			ServletActionContext.getResponse().getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
