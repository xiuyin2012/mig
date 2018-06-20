
/**
 * Created by root on 1/31/18.
 */
package com.clo.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.exceptions.JedisConnectionException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class JedisPoolUtils {

    private static JedisPool pool;
    static String Auth = null;
    static String URL = "";
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
        // 设置连接
        config.setMaxIdle(10);

        //在borrow(引入)一个jedis实例时，是否提前进行validate操作；如果为true，则得到的jedis实例均是可用的；
        //config.setTestOnBorrow(true);
        //return 一个jedis实例给pool时，是否检查连接可用性（ping()）
        //config.setTestOnReturn(true);
        Context ctx = null;
        //String url = null;
        try {
            ctx = (Context) new InitialContext().lookup("java:comp/env");
            URL = (String) ctx.lookup("redisUrl");
        } catch (NamingException e) {
            e.printStackTrace();

        }
        // 创建连接池
        String[] urlArray =  URL.split(":");
        if(urlArray.length==3)Auth = urlArray[2];
        pool = new JedisPool(config, urlArray[0],Integer.valueOf(urlArray[1]),10*1000,Auth);

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
        if (pool == null) poolInit();
        Jedis jedis = null;
        boolean exceptionflag = true;
        try{
            jedis = pool.getResource();
        }catch (JedisConnectionException e){
            e.printStackTrace();
            exceptionflag = false;
/*            if (jedis != null)
                pool.returnBrokenResource(jedis);*/
        }finally {
            //bizClass have closed jedis through 'jedis.close',so cancel here
/*            if (exceptionflag)
                pool.returnResourceObject(jedis);*/
        }
        return jedis;
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