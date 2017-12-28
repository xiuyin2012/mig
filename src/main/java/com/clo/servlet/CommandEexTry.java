package com.clo.servlet;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Vector;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.UserInfo;

/**
 * This class provide interface to execute command on remote Linux.
 */

public class CommandEexTry {
	private String ipAddress;

	private String username;

	private String password;

	public static final int DEFAULT_SSH_PORT = 22;

	private Vector<String> stdout;

	public CommandEexTry(final String ipAddress, final String username,
			final String password) {
		this.ipAddress = ipAddress;
		this.username = username;
		this.password = password;
		stdout = new Vector<String>();
	}

	public int execute(final String command) {
		int returnCode = 0;
		JSch jsch = new JSch();
		UserInfo userInfo = new SshUserInfo("");

		try {
			// Create and connect session.
			Session session = jsch.getSession(username, ipAddress,
					DEFAULT_SSH_PORT);
			session.setPassword(password);
			session.setUserInfo(userInfo);
			session.connect();

			// Create and connect channel.
			Channel channel = session.openChannel("exec");
			((ChannelExec) channel).setCommand(command);

			channel.setInputStream(null);
			BufferedReader input = new BufferedReader(new InputStreamReader(
					channel.getInputStream()));

			channel.connect();
			System.out.println("The remote command is: " + command);

			// Get the output of remote command.
			String line;
			while ((line = input.readLine()) != null) {
				stdout.add(line);
			}
			input.close();

			// Get the return code only after the channel is closed.
			if (channel.isClosed()) {
				returnCode = channel.getExitStatus();
			}

			// Disconnect the channel and session.
			channel.disconnect();
			session.disconnect();
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnCode;
	}

	public Vector<String> getStandardOutput() {
		return stdout;
	}

	public static void main(final String[] args) {
		CommandEexTry sshExecutor = new CommandEexTry("xx.xx.xx.xx",
				"username", "password");
		sshExecutor.execute("uname -s -r -v");

		Vector<String> stdout = sshExecutor.getStandardOutput();
		for (String str : stdout) {
			System.out.println(str);
		}
	}
}

class SshUserInfo implements UserInfo {

	private String passphrase = null;

	public SshUserInfo(String passphrase) {
		super();
		this.passphrase = passphrase;
	}

	public String getPassphrase() {
		return passphrase;
	}

	public String getPassword() {
		return null;
	}

	public boolean promptPassphrase(String pass) {
		return true;
	}

	public boolean promptPassword(String pass) {
		return true;
	}

	public boolean promptYesNo(String arg0) {
		return true;
	}

	public void showMessage(String m) {
		System.out.println(m);
	}
}