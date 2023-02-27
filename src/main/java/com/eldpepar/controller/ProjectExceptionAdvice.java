package com.eldpepar.controller;

import com.eldpepar.exception.BusinessException;
import com.eldpepar.exception.SystemException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ProjectExceptionAdvice {

    @ExceptionHandler(SystemException.class)
    public Result doSystemException(SystemException exception) {
        //开发过程中发生系统异常需要进行如下操作
        //1.记录日志
        //2.发送消息给运维
        //3.发送邮件给开发人员，ex对象发送给开发人员
        return new Result(exception.getCode(), null, exception.getMessage());
    }

    @ExceptionHandler(BusinessException.class)
    public Result doBusinessException(BusinessException exception) {
        return new Result(exception.getCode(), null, exception.getMessage());
    }

    @ExceptionHandler(Exception.class)
    public Result doException(Exception ex) {
        return new Result(Code.SYSTEM_UNKNOW_ERR,null,"系统繁忙，请稍后再试！");
    }
}
