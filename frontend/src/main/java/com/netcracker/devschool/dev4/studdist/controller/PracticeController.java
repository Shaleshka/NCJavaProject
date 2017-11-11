package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.entity.Practice;
import com.netcracker.devschool.dev4.studdist.service.PracticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping(value = "/practice")
public class PracticeController {

    @Autowired
    private PracticeService practiceService;

    @RequestMapping(value = "/getByHop/{id}", method = RequestMethod.GET)
    @ResponseBody
    private List<Practice> getByHopId(@PathVariable String id) {
        return practiceService.findByHopId(Integer.parseInt(id));
    }

}
