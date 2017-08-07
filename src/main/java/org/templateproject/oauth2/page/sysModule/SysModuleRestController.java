package org.templateproject.oauth2.page.sysModule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthSystemModule;
import org.templateproject.oauth2.service.SystemModuleService;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.pojo.bo.SystemModuleBo;
import org.templateproject.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.oauth2.support.pojo.vo.SystemModuleVO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * 系统面模块数据处理层
 * Created by zhangteng on 2017/7/14.
 */
@RequestMapping("/oauth2/system-module/api")
@RestController
public class SysModuleRestController extends BaseRestController {

        //下方注入系统模块相关的service
        private SystemModuleService systemModuleService;

        @Autowired
        public void setSystemModuleService(SystemModuleService systemModuleService) {
                this.systemModuleService = systemModuleService;
        }

        /**
         * 系统模块列表
         *
         * @param page           页面对象
         * @param systemModuleBo 页面查询对象
         * @return 页面对象（包含数据、分页、查询等信息）
         */
        @RequestMapping("list")
        public BootstrapTable<SystemModuleVO> list(Page<SystemModuleVO> page, SystemModuleBo systemModuleBo) {
                page = systemModuleService.findSystemModulePage( page, systemModuleBo);
                return bootstrapTable(page);
        }

        /**
         * 系统模块的添加处理
         *
         * @param systemModule 添加的系统模块对象
         * @return 添加处理情况
         */
        @RequestMapping("add")
        public R add(OauthSystemModule systemModule) {
                if (systemModuleService.isExistSystemCode(systemModule.getSystemCode()))
                        return R.error("系统模块代码已存在");
                else {
                        try {
                                if (systemModuleService.save(systemModule, OauthSystemModule.class))
                                        return R.ok("添加系统模块成功");
                                else
                                        return R.error("添加系统模块失败");
                        } catch (Exception e) {
                                LOGGER.error("添加系统模块发生异常，异常信息：{}", e.getMessage());
                                return R.error("添加系统模块发生异常，异常信息：" + e.getMessage());
                        }
                }
        }

        /**
         * 修改系统模块的操作
         *
         * @param systemModule 修改的系统模块对象
         * @return 修改处理结果
         */
        @RequestMapping("edit")
        public R doEdit(OauthSystemModule systemModule) {
                try {
                        if (systemModuleService.edit(systemModule, OauthSystemModule.class))
                                return R.ok("修改系统模块成功");
                        else
                                return R.error("修改系统模块失败");
                } catch (Exception e) {
                        LOGGER.error("修改系统模块发生异常，异常信息：{}", e.getMessage());
                        return R.error("修改系统模块发生异常，异常信息：" + e.getMessage());
                }
        }


        /**
         * 删除系统模块处理操作，实际上就是逻辑删除，修改enabled字段为0，即不可用
         *
         * @param ids 删除模块对象的id集合字符串
         * @return 删除的处理结果
         */
        @RequestMapping("delete")
        public R delete(String ids) {
                String[] idArr = ids.split(",");
                try {
                        systemModuleService.deleteModules( idArr);
                        return R.ok("删除/修改系统模块成功");
                } catch (Exception e) {
                        LOGGER.error("删除/修改系统模块发生异常，异常信息：{}", e.getMessage());
                        return R.error("删除/修改系统模块发生异常，异常信息：" + e.getMessage());
                }
        }

        /**
         * @return 获取所有可用的系统模块
         */
        @RequestMapping("find/modules/enabled")
        public List<OauthSystemModule> findModulesEnabled() {
                return systemModuleService.findAllEnabledSystemModules();
        }

        /**
         * 获取系统模块的zTree树，无异步加载
         *
         * @return List<ZTreeBO>
         */
        @RequestMapping("/find/modules/enabled/moduleTree")
        public List<ZTreeBO<String>> findModulesTreeEnabled() {
                return systemModuleService.module2ZTree(systemModuleService.findAllEnabledSystemModules());
        }

}
