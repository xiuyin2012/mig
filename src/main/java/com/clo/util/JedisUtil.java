package com.clo.util;

import java.util.List;
import java.util.Map;
import java.util.Set;
//import java.util.logging.Logger;

import javax.security.auth.Destroyable;

import org.apache.log4j.Logger;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class JedisUtil {

	Logger logger = Logger.getLogger(JedisUtil.class);
	private static String JEDIS_IP;
	private static int JEDIS_PORT;
	private static String JEDIS_PASSWORD;
	// private static String JEDIS_SLAVE;

	private static JedisPool jedisPool;
    private static JedisPoolConfig config;
	static {
		// Configuration conf = Configuration.getInstance();
		JEDIS_IP = "172.18.60.119";
		JEDIS_PORT = 6379;
		JEDIS_PASSWORD = "";
		config = new JedisPoolConfig();
		// config.setMaxActive(5000);
		// config.setMaxWait(5000L);
		config.setTestOnBorrow(true);
		config.setTestOnReturn(true);
		config.setTestWhileIdle(true);
		config.setMinEvictableIdleTimeMillis(60000l);
		config.setTimeBetweenEvictionRunsMillis(3000l);
		config.setNumTestsPerEvictionRun(-1);

        config.setMaxWaitMillis(10 * 1000);
        config.setMaxIdle(1000);

    }

	Jedis jedis = null;
	/**
	 * ��ȡ����
	 * 
	 * @param key
	 * @return
	 */
	public static String get(String key) {

		String value = null;
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			value = jedis.get(key);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}

		return value;
	}

	/**
	 * 同步获取Jedis实例
	 * @return Jedis
	 */
	public synchronized Jedis getJedis() {

		Jedis jedis = null;

		try {
			jedisPool = new JedisPool(config, JEDIS_IP, JEDIS_PORT, 60000);
			if (jedisPool != null) {
				jedis = jedisPool.getResource();
			}
		} catch (Exception e) {
			logger.error("Get jedis error : "+e);
			e.printStackTrace();
		}finally{
			jedisPool.returnResourceObject(jedis);
		}
		return jedis;
	}

	/**
	 * 获取list
	 * @param
	 * @param key
	 * @return list
	 */
	public List<String> getList(String key){
		if(getJedis() == null || !getJedis().exists(key.getBytes())){
			return null;
		}
		List<String> list = getJedis().lrange("lofts",0,-1);
		logger.info("lofts==============="+list.get(0));
		System.out.println("lofts============"+list.get(0));
		//List<T> list = (List<T>) ObjectTranscoder.deserialize(in);
		return list;
	}

	public static void close(Jedis jedis) {
		try {
			jedisPool.returnResource(jedis);

		} catch (Exception e) {
			if (jedis.isConnected()) {
				jedis.quit();
				jedis.disconnect();
			}
		}
	}

	/**
	 * ��ȡ����
	 * 
	 * @param key
	 * @return
	 */
	public static byte[] get(byte[] key) {

		byte[] value = null;
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			value = jedis.get(key);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}

		return value;
	}

	public static void set(byte[] key, byte[] value) {

		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.set(key, value);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}
	}

	public static void set(byte[] key, byte[] value, int time) {

		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.set(key, value);
			jedis.expire(key, time);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}
	}

	public static void hset(byte[] key, byte[] field, byte[] value) {
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.hset(key, field, value);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}
	}

	public static void hset(String key, String field, String value) {
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.hset(key, field, value);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}
	}

	/**
	 * ��ȡ����
	 * 
	 * @param key
	 * @return
	 */
	public static String hget(String key, String field) {

		String value = null;
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			value = jedis.hget(key, field);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}

		return value;
	}

	/**
	 * ��ȡ����
	 * 
	 * @param key
	 * @return
	 */
	public static byte[] hget(byte[] key, byte[] field) {

		byte[] value = null;
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			value = jedis.hget(key, field);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}

		return value;
	}

	public static void hdel(byte[] key, byte[] field) {

		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.hdel(key, field);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}
	}

	/**

	 */
	public static void lpush(byte[] key, byte[] value) {

		Jedis jedis = null;
		try {

			jedis = jedisPool.getResource();
			jedis.lpush(key, value);

		} catch (Exception e) {

			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {

			// ���������ӳ�
			close(jedis);

		}
	}

	/**
	 *
	 * 

	 */
	public static void rpush(byte[] key, byte[] value) {

		Jedis jedis = null;
		try {

			jedis = jedisPool.getResource();
			jedis.rpush(key, value);

		} catch (Exception e) {

			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {

			// ���������ӳ�
			close(jedis);

		}
	}

	/**
	 *
	 */
	public static void rpoplpush(byte[] key, byte[] destination) {

		Jedis jedis = null;
		try {

			jedis = jedisPool.getResource();
			jedis.rpoplpush(key, destination);

		} catch (Exception e) {

			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {

			// ���������ӳ�
			close(jedis);

		}
	}

	/**
	 *
	 * @return
	 */
	public static List<byte[]> lpopList(byte[] key) {

		List<byte[]> list = null;
		Jedis jedis = null;
		try {

			jedis = jedisPool.getResource();
			list = jedis.lrange(key, 0, -1);

		} catch (Exception e) {

			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {

			// ���������ӳ�
			close(jedis);

		}
		return list;
	}

	/**
	 * 
	 * @param
	 * @return
	 */
	public static byte[] rpop(byte[] key) {

		byte[] bytes = null;
		Jedis jedis = null;
		try {

			jedis = jedisPool.getResource();
			bytes = jedis.rpop(key);

		} catch (Exception e) {

			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {

			// ���������ӳ�
			close(jedis);

		}
		return bytes;
	}

	public static void hmset(Object key, Map<String, String> hash) {
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.hmset(key.toString(), hash);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {
			// ���������ӳ�
			close(jedis);

		}
	}

	public static void hmset(Object key, Map<String, String> hash, int time) {
		Jedis jedis = null;
		try {

			jedis = jedisPool.getResource();
			jedis.hmset(key.toString(), hash);
			jedis.expire(key.toString(), time);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {
			// ���������ӳ�
			close(jedis);

		}
	}

	public static List<String> hmget(Object key, String... fields) {
		List<String> result = null;
		Jedis jedis = null;
		try {

			jedis = jedisPool.getResource();
			result = jedis.hmget(key.toString(), fields);

		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {
			// ���������ӳ�
			close(jedis);

		}
		return result;
	}

	public static Set<String> hkeys(String key) {
		Set<String> result = null;
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			result = jedis.hkeys(key);

		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {
			// ���������ӳ�
			close(jedis);

		}
		return result;
	}

	public static List<byte[]> lrange(byte[] key, int from, int to) {
		List<byte[]> result = null;
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			result = jedis.lrange(key, from, to);

		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();

		} finally {
			// ���������ӳ�
			close(jedis);

		}
		return result;
	}

	/*
	 * public static Map<byte[]> hgetAll(byte[] key) { Map<byte[]> result =
	 * null; Jedis jedis = null; try { jedis = jedisPool.getResource(); result =
	 * jedis.hgetAll(key); } catch (Exception e) { //�ͷ�redis����
	 * jedisPool.returnBrokenResource(jedis); e.printStackTrace();
	 * 
	 * } finally { //���������ӳ� close(jedis); } return result; }
	 */

	public static void del(byte[] key) {

		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.del(key);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}
	}

	public static long llen(byte[] key) {

		long len = 0;
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.llen(key);
		} catch (Exception e) {
			// �ͷ�redis����
			jedisPool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			close(jedis);
		}
		return len;
	}

	public static void destroy() {
		jedisPool = null;
	}

}
