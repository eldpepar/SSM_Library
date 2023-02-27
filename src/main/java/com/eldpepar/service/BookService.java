package com.eldpepar.service;

import com.eldpepar.domain.Book;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Transactional
public interface BookService {
    /**
     * 保存
     * @param book
     * @return
     */
    public boolean save(Book book);

    /**
     * 修改
     * @param book
     * @return
     */
    public boolean update(Book book);

    /**
     * 按ID删除
     * @param id
     * @return
     */
    public boolean delete(Integer id);

    /**
     * 按ID查询
     * @param id
     * @return
     */
    public Book getById(Integer id);

    /**
     * 查询全部
     * @return
     */
    public List<Book> getAll();
}
