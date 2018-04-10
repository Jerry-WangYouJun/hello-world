package com.saki.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TSupllierOrder entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_supllier_order", catalog = "order")

public class TSupllierOrder implements java.io.Serializable {

	// Fields

	private Integer id;
	private String supplierOrderNo;
	private Date transportDate;
	private String status;
	private double amount;
	private String remark;

	// Constructors

	/** default constructor */
	public TSupllierOrder() {
	}

	/** full constructor */
	public TSupllierOrder(String supplierOrderNo, Date transportDate, String status, double amount, String remark) {
		this.supplierOrderNo = supplierOrderNo;
		this.transportDate = transportDate;
		this.status = status;
		this.amount = amount;
		this.remark = remark;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")

	@Column(name = "id", unique = true, nullable = false)

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "supplier_order_no", length = 30)

	public String getSupplierOrderNo() {
		return this.supplierOrderNo;
	}

	public void setSupplierOrderNo(String supplierOrderNo) {
		this.supplierOrderNo = supplierOrderNo;
	}

	@Column(name = "transport_date", length = 19)

	public Date getTransportDate() {
		return this.transportDate;
	}

	public void setTransportDate(Date transportDate) {
		this.transportDate = transportDate;
	}

	@Column(name = "status", length = 5)

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "amount", precision = 10, scale = 5)

	public double getAmount() {
		return this.amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}