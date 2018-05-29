package com.saki.action;

import java.io.IOException;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TCompany;
import com.saki.model.TUser;
import com.saki.service.CompanyServiceI;
import com.saki.service.UserServiceI;

@Namespace("/")
@Action(value="companyAction")
public class CompanyAction extends BaseAction implements ModelDriven<TCompany>{

	private TCompany company = new TCompany();
	private CompanyServiceI companyService;
	private UserServiceI userService;
	public UserServiceI getUserService() {
		return userService;
	}
	@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}
	@Override
	public TCompany getModel() {
		return company;
	}
	public CompanyServiceI getCompanyService() {
		return companyService;
	}
	@Autowired
	public void setCompanyService(CompanyServiceI companyService) {
		this.companyService = companyService;
	}
	public void loadAll(){
		super.writeJson(companyService.loadAll(sort, order, page, rows));
	}
	public void listAll(){
		super.writeJson(companyService.loadAll(sort, order, page, rows).getRows());
	}
	public void add(){
		Message j = new Message();
		try{
			companyService.add(company);
			TUser user = new TUser();
			String roleId = getParameter("roleId");
			String userName = getParameter("userName");
			user.setRoleId(Integer.valueOf(roleId));
			user.setCompanyId(company.getId());
			user.setUserName(userName);
			userService.add(user);
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
			companyService.update(company);
			TUser user = userService.getByCompanyId(company.getId());
			String roleId = getParameter("roleId");
			String userName = getParameter("userName");
			user.setRoleId(Integer.valueOf(roleId));
			user.setCompanyId(company.getId());
			user.setUserName(userName);
			userService.update(user);
			j.setSuccess(true);
			j.setMsg("更新成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("更新失败");
		}
		super.writeJson(j);
		
	}
	public void delete(){
		Message j = new Message();
		try{
			companyService.deleteByKey(company.getId().toString());
			System.out.println(company.getId());
			userService.deleteByCompanyId(company.getId());
			j.setSuccess(true);
			j.setMsg("删除成功");
		}catch(Exception e){
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("删除失败");
		}
		super.writeJson(j);
		
	}
	public void search(){
		super.writeJson(companyService.search(name, value,sort, order, page, rows));
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
