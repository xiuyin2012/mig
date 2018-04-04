
/**
 * Created by root on 1/31/18.
 */
package com.clo.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class JedisPoolUtils {

    private static JedisPool pool;

    /**
     * 建立连接池 真实环境，一般把配置参数缺抽取出来。
     *
     */
    private static void createJedisPool() {

        // 建立连接池配置参数
        JedisPoolConfig config = new JedisPoolConfig();

        // 设置最大连接数
       //config.setMaxActive(100);
        config.setMaxTotal(100);
        // 设置最大阻塞时间，记住是毫秒数milliseconds
        config.setMaxWaitMillis(10*1000);
        // 设置空间连接
        config.setMaxIdle(10);
        Context ctx = null;
        String url = null;
        try {
            ctx = (Context) new InitialContext().lookup("java:comp/env");
            url = (String) ctx.lookup("redisUrl");
        } catch (NamingException e) {
            e.printStackTrace();
        }
        // 创建连接池
        pool = new JedisPool(config, url.split(":")[0],Integer.valueOf(url.split(":")[1]));

    }

    /**
     * 在多线程环境同步初始化
     */
    private static synchronized void poolInit() {
        if (pool == null)
            createJedisPool();
    }

    /**
     * 获取一个jedis 对象
     *
     * @return
     */
    public static Jedis getJedis() {

        if (pool == null)
            poolInit();
        return pool.getResource();
    }

    /**
     * 归还一个连接
     *
     * @param jedis
     */
    public static void returnRes(Jedis jedis) {
        pool.returnResourceObject(jedis);
    }

}