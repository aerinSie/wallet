
package com.carcomplain.model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class CarComplainJNDIDAO implements CarComplainDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/BA104G1DB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 新增申訴
	private static final String INSERT_STMT = 
			"INSERT INTO CARCOMPLAIN (COMPLAINNO, ORDER_NO, COMPLAINDETAIL, COMPLAINSTATUS) VALUES (to_char('CR'||LPAD(to_char(CARCOM_NO_SEQ.NEXTVAL),6,'0')), ?, ?, ? )";
	
	// 修改申訴
	private static final String UPDATE = 
			"UPDATE CARCOMPLAIN SET COMPLAINREPLY=?, REPLYDATE=CURRENT_TIMESTAMP, EMP_NO =?, COMPLAINSTATUS =? WHERE COMPLAINNO = ?";
	
	// 查全部申訴
	private static final String GET_ALL_STMT =
			"SELECT COMPLAINNO, ORDER_NO, COMPLAINDETAIL, DETAILDATE , COMPLAINREPLY, REPLYDATE, EMP_NO ,COMPLAINSTATUS FROM CARCOMPLAIN ORDER BY COMPLAINNO";
	
	// 申訴單號單一查詢
	private static final String GET_ONE_STMT = 
			"SELECT COMPLAINNO, ORDER_NO, COMPLAINDETAIL, DETAILDATE , COMPLAINREPLY, REPLYDATE, EMP_NO ,COMPLAINSTATUS  FROM CARCOMPLAIN WHERE COMPLAINNO=?";

	
	// 申訴單號已完成查詢
		private static final String GET_ONCOM_STMT = 
				"SELECT COMPLAINNO, ORDER_NO, COMPLAINDETAIL, DETAILDATE , COMPLAINREPLY, REPLYDATE, EMP_NO ,COMPLAINSTATUS  FROM CARCOMPLAIN WHERE COMPLAINSTATUS='已完成'";

		// 申訴單號已完成查詢
		private static final String GET_OFFCOM_STMT = 
				"SELECT COMPLAINNO, ORDER_NO, COMPLAINDETAIL, DETAILDATE , COMPLAINREPLY, REPLYDATE, EMP_NO ,COMPLAINSTATUS  FROM CARCOMPLAIN WHERE COMPLAINSTATUS='未處理'";

	// 刪除
		private static final String DELETE = 
				"DELETE FROM CARCOMPLAIN WHERE COMPLAINNO = ?";
	
	
	
	@Override
	public void insert(CarComplainVO carComplainVO){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, carComplainVO.getOrder_no());
			pstmt.setString(2, carComplainVO.getComplainDetail());
			pstmt.setString(3, carComplainVO.getComplainStatus());
			pstmt.executeQuery();
			

		// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			
		// Clean up JDBC resources
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con != null){
				try{
					con.close();
				} catch(Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public void update(CarComplainVO carComplainVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, carComplainVO.getComplainReply());
			pstmt.setString(2, carComplainVO.getEmp_no());
			pstmt.setString(3, carComplainVO.getComplainStatus());
			pstmt.setString(4, carComplainVO.getComplainNo());
			
			pstmt.executeQuery();
		
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
				+ se.getMessage());
							
			// Clean up JDBC resources
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
		if(con != null){
			try {
				con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public CarComplainVO findByPrimaryKey(String complainNo) {
		CarComplainVO carComplainVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, complainNo);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				carComplainVO = new CarComplainVO();
				carComplainVO.setComplainNo(rs.getString("complainNo"));
				carComplainVO.setOrder_no(rs.getString("order_no"));
				carComplainVO.setComplainDetail(rs.getString("complainDetail"));
				carComplainVO.setDetailDate(rs.getTimestamp("detailDate"));
				carComplainVO.setComplainReply(rs.getString("complainReply"));
				carComplainVO.setReplyDate(rs.getTimestamp("replyDate"));
				carComplainVO.setEmp_no(rs.getString("emp_no"));
				carComplainVO.setComplainStatus(rs.getString("complainStatus"));
			}
			
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);					
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return carComplainVO;
	}

	
	@Override
	public List<CarComplainVO> getOffAll() {
		List<CarComplainVO> list = new ArrayList<CarComplainVO>();
		CarComplainVO carComplainVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_OFFCOM_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				carComplainVO = new CarComplainVO();
				carComplainVO.setComplainNo(rs.getString("complainNo"));
				carComplainVO.setOrder_no(rs.getString("order_no"));
				carComplainVO.setComplainDetail(rs.getString("complainDetail"));
				carComplainVO.setDetailDate(rs.getTimestamp("detailDate"));
				carComplainVO.setComplainReply(rs.getString("complainReply"));
				carComplainVO.setReplyDate(rs.getTimestamp("replyDate"));
				carComplainVO.setEmp_no(rs.getString("emp_no"));
				carComplainVO.setComplainStatus(rs.getString("complainStatus"));
				list.add(carComplainVO);
			}
			
			
			
			
			
		
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
		// Clean up JDBC resources
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			
			if(con != null){
				try {
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	
	@Override
	public List<CarComplainVO> getOnAll() {
		List<CarComplainVO> list = new ArrayList<CarComplainVO>();
		CarComplainVO carComplainVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONCOM_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				carComplainVO = new CarComplainVO();
				carComplainVO.setComplainNo(rs.getString("complainNo"));
				carComplainVO.setOrder_no(rs.getString("order_no"));
				carComplainVO.setComplainDetail(rs.getString("complainDetail"));
				carComplainVO.setDetailDate(rs.getTimestamp("detailDate"));
				carComplainVO.setComplainReply(rs.getString("complainReply"));
				carComplainVO.setReplyDate(rs.getTimestamp("replyDate"));
				carComplainVO.setEmp_no(rs.getString("emp_no"));
				carComplainVO.setComplainStatus(rs.getString("complainStatus"));
				list.add(carComplainVO);
			}
			
			
		
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
		// Clean up JDBC resources
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			
			if(con != null){
				try {
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	
	
	
	
	
	@Override
	public List<CarComplainVO> getAll(){
		List<CarComplainVO> list = new ArrayList<CarComplainVO>();
		CarComplainVO carComplainVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				carComplainVO = new CarComplainVO();
				carComplainVO.setComplainNo(rs.getString("complainNo"));
				carComplainVO.setOrder_no(rs.getString("order_no"));
				carComplainVO.setComplainDetail(rs.getString("complainDetail"));
				carComplainVO.setDetailDate(rs.getTimestamp("detailDate"));
				carComplainVO.setComplainReply(rs.getString("complainReply"));
				carComplainVO.setReplyDate(rs.getTimestamp("replyDate"));
				carComplainVO.setEmp_no(rs.getString("emp_no"));
				carComplainVO.setComplainStatus(rs.getString("complainStatus"));
				list.add(carComplainVO);
			}
			
			
		
		// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
		// Clean up JDBC resources
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			
			if(con != null){
				try {
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	@Override
	public void delete(String complainNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, complainNo);
			
			pstmt.executeUpdate();
			
			
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	
	
	public static void main(String[] args){
		
		CarComplainJNDIDAO dao = new CarComplainJNDIDAO();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		// 新增

//			CarComplainVO carComplainVO1 = new CarComplainVO();
//			carComplainVO1.setOrder_no("20171104-000005");
//			carComplainVO1.setComplainDetail("司機太帥太犯規");
//			carComplainVO1.setComplainStatus("未處理");
//			dao.insert(carComplainVO1);
//			System.out.println("新增成功");

//		
		
		// 修改
		CarComplainVO carComplainVO2 = new CarComplainVO();
		carComplainVO2.setComplainNo("CR000005");
		carComplainVO2.setEmp_no("EMP0001");	
		carComplainVO2.setComplainReply("小天使來解答,我們會再跟進!!!!");
		carComplainVO2.setComplainStatus("已完成");
		dao.update(carComplainVO2);
		System.out.println("修改成功阿阿阿阿阿");
		
		
		// 查單個
//		CarComplainVO carComplainVO3 = dao.findByPrimaryKey("CR000016");
//		System.out.println("ComplainNo : " + carComplainVO3.getComplainNo());
//		System.out.println("OrderNO : " + carComplainVO3.getOrder_no());
//		System.out.println("ComplainDetail : " + carComplainVO3.getComplainDetail());
//		System.out.println("DetailDate : " + carComplainVO3.getDetailDate());
//		System.out.println("ComplainReply : " + carComplainVO3.getComplainReply());
//		System.out.println("ReplyDate : " + carComplainVO3.getReplyDate());
//		System.out.println("EmpNO : " + carComplainVO3.getEmp_no());
//		System.out.println("Status : " + carComplainVO3.getComplainStatus());
//		System.out.println();
		
		
		
		// 查全部
//		List<CarComplainVO> list = dao.getAll();
//		for(CarComplainVO carComplainVO : list){
//			System.out.println("ComplainNo : " + carComplainVO.getComplainNo());
//			System.out.println("OrderNO : " + carComplainVO.getOrder_no());
//			System.out.println("ComplainDetail : " + carComplainVO.getComplainDetail());
//			System.out.println("DetailDate : " + sdf.format(carComplainVO.getDetailDate()));
//			System.out.println("ComplainReply : " + carComplainVO.getComplainReply());
//			System.out.println("ReplyDate : " + sdf.format(carComplainVO.getReplyDate()));
//			System.out.println("EmpNO : " + carComplainVO.getEmp_no());
//			System.out.println("Status : " + carComplainVO.getComplainStatus());
//			System.out.println();
//		}
	}


	
}
