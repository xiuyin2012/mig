package com.clo.cache;

import java.util.List;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

public class Ehcache {

	private static CacheManager cacheManager;

	public static void createCache(String cacheNm) {
		cacheManager = CacheManager.create();
		cacheManager.addCache(cacheNm);
	}

	public static void addehCache(String cacheNm, String key,
			List<Object> containList) {
		Cache cache = cacheManager.getCache(cacheNm);
		cache.put(new Element(key, containList));
	}

	public static Element getehCache(String cacheNm, String key) {
		Cache cache = cacheManager.getCache(cacheNm);
		return cache.get(key);
	}

	public static void destoryCache(String cacheNm) {
		cacheManager.removeCache(cacheNm);
	}

	public static void destoryAllCache() {
		cacheManager.removalAll();
	}

}
