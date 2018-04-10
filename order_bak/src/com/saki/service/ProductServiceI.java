package com.saki.service;

import java.util.ArrayList;

import com.saki.entity.Product;

public interface ProductServiceI extends BaseServiceI{
	public ArrayList<Product> listAll();
	public ArrayList<Product> listByCompany(int companyId);

}
