package com.message.model;

import java.sql.*;
import java.util.*;
import java.io.*;

public class MessageJDBCDAO implements MessageDAO_Interface {
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String userid = "BA104G1DB";
	String passwd = "BA104G1DB";
	

//	// ************* Localhost **********
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	

	private static final String INSERT_STMT = "insert into message (msg_no, mem_no, com_no, content) values (ltrim(to_char(msg_no_seq.nextval,'0009')), ?, ?, ?)";
	private static final String GET_ALL_STMT = "select msg_no, mem_no, com_no, content from message order by msg_no";
	private static final String GET_ONE_STMT = "select msg_no, mem_no, com_no, content from message where msg_no = ?";
	private static final String DELETE = "delete from message where msg_no = ?";
	private static final String UPDATE = "update message set mem_no=?, com_no=?, content=? where msg_no = ?";

	@Override
	public void insert(MessageVO messageVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String[] cols = { "msg_no" };
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT, cols);
			pstmt.setString(1, messageVO.getMem_no());
			pstmt.setString(2, messageVO.getCom_no());

			Clob clob = con.createClob();
			String str = messageVO.getContent();
			clob.setString(1, str);
			pstmt.setClob(3, clob);
			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

	@Override
	public void update(MessageVO messageVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, messageVO.getMem_no());
			pstmt.setString(2, messageVO.getCom_no());

			Clob clob = con.createClob();
			String str = messageVO.getContent();
			clob.setString(1, str);
			pstmt.setClob(3, clob);

			pstmt.setString(4, messageVO.getMsg_no());
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

	@Override
	public void delete(String msg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, msg_no);
			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

	@Override
	public MessageVO findByPrimaryKey(String msg_no) {
		MessageVO messageVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, msg_no);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				messageVO = new MessageVO();
				messageVO.setMsg_no(rs.getString("msg_no"));
				messageVO.setMem_no(rs.getString("mem_no"));
				messageVO.setCom_no(rs.getString("com_no"));

				Clob clob = rs.getClob("content");
				StringBuilder sb = new StringBuilder();
				BufferedReader br = new BufferedReader(clob.getCharacterStream());
				String str;
				while ((str = br.readLine()) != null) {
					sb.append(str);
					sb.append("\n");
				}
				br.close();
				messageVO.setContent(sb.toString());
			}
		} catch (IOException e) {
			System.out.println(e);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		return messageVO;
	}

	@Override
	public List<MessageVO> getAll() {
		List<MessageVO> list = new ArrayList<MessageVO>();
		MessageVO messageVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				messageVO = new MessageVO();
				messageVO.setMsg_no(rs.getString("msg_no"));
				messageVO.setMem_no(rs.getString("mem_no"));
				messageVO.setCom_no(rs.getString("com_no"));

				Clob clob = rs.getClob("content");
				StringBuilder sb = new StringBuilder();
				BufferedReader br = new BufferedReader(clob.getCharacterStream());
				String str;
				while ((str = br.readLine()) != null) {
					sb.append(str);
					sb.append("\n");
				}
				br.close();
				messageVO.setContent(sb.toString());
				list.add(messageVO);
			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} catch (IOException ie) {
			System.out.println(ie);
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

		return list;
	}

	@Override
	public List<String> getMessageByMem_no(String mem_no) {
		// TODO Auto-generated method stub
		return null;
	}
}
