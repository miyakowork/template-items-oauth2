/**
 * 登录验证js
 * Created by Administrator on 2017/7/12.
 */
var vm = new Vue({
    el: "#login-form",
    data: {
        username: '',
        password: '',
        error: false,
        errorMsg: '',
        rememberMe: false
    },
    beforeCreate: function () {
        if (self !== top) {
            top.location.href = self.location.href;
        }
    },
    methods: {
        login: function () {
            vm.error = false;
            var params = new URLSearchParams();
            params.append("userName", vm.username);
            params.append("userPass", Base64.encode(vm.password));
            params.append("rememberMe", vm.rememberMe);
            axios.post('/login/', params, {headers: {'X-Requested-With': 'XMLHttpRequest'}})
                .then(function (result) {
                    result = result.data;
                    var target = result.data;
                    if (result.code === 200) {//登录成功
                        parent.location.href = target;
                    } else if (result.code === 302) {
                        parent.location.href = target;
                    } else {
                        vm.error = true;
                        vm.errorMsg = result.message;
                    }
                })
                .catch(function (error) {
                    vm.error = true;
                    if (error.responseJSON)
                        vm.errorMsg = error.responseJSON.data.error || error.responseJSON.message;
                    else vm.errorMsg = '\u53d1\u751f\u672a\u77e5\u9519\u8bef';//发生未知错误
                });

        }
    }
})