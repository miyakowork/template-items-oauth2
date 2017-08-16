package org.templateproject.items.oauth2.config.support.password;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Component;
import org.templateproject.items.oauth2.entity.IUser;

/**
 * 用户密码操作
 * 可实现加密用户密码等
 * Created by wuwenbin on 2017/4/18.
 */
@Component
public class PasswordHelper {

    private RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
    private String algorithmName = "md5";
    private int hashIterations = 2;

    public void setRandomNumberGenerator(RandomNumberGenerator randomNumberGenerator) {
        this.randomNumberGenerator = randomNumberGenerator;
    }

    public void setAlgorithmName() {
        this.algorithmName = "md5";
    }

    public void setHashIterations() {
        this.hashIterations = 2;
    }

    /**
     * 密码加密
     *
     * @param user 用户对象
     */
    public void encryptPassword(IUser user) {
        user.setSalt(randomNumberGenerator.nextBytes().toHex());
        String newPassword = new SimpleHash(algorithmName, user.getPassword(),
                ByteSource.Util.bytes(user.getCredentialsSalt()),
                hashIterations).toHex();
        user.setPassword(newPassword);
    }

    /**
     * 加密User，同时返回加密之后的密码
     *
     * @param user 用户对象
     * @return 加密后的用户密码
     */
    public String getPassword(IUser user) {
        return new SimpleHash(algorithmName, user.getPassword(),
                ByteSource.Util.bytes(user.getCredentialsSalt()),
                hashIterations).toHex();
    }

    /**
     * 根据明文密码获取加密密码
     *
     * @param user          不含密码的用户对象
     * @param plainPassword 明文密码
     * @return 加密后的密码
     */
    public String getPassword(IUser user, String plainPassword) {
        return new SimpleHash(algorithmName, plainPassword,
                ByteSource.Util.bytes(user.getCredentialsSalt()),
                hashIterations).toHex();
    }

}
