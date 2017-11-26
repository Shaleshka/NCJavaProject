package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.beans.PracticeViewModel;
import com.netcracker.devschool.dev4.studdist.entity.HeadOfPractice;
import com.netcracker.devschool.dev4.studdist.entity.Practice;
import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.service.HeadOfPracticeService;
import com.netcracker.devschool.dev4.studdist.service.PracticeService;
import com.netcracker.devschool.dev4.studdist.service.StudentService;
import com.netcracker.devschool.dev4.studdist.utils.Event;
import com.netcracker.devschool.dev4.studdist.utils.StudentsConverter;
import com.netcracker.devschool.dev4.studdist.utils.TableData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/practice")
public class PracticeController {

    @Autowired
    private PracticeService practiceService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private StudentsConverter converter;

    @Autowired
    private HeadOfPracticeService headOfPracticeService;

    @Autowired
    private ConversionService conversionService;

    @RequestMapping(value = "/getByHop/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<Practice> getByHopId(@PathVariable String id) {
        return practiceService.findByHopId(Integer.parseInt(id));
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public PracticeViewModel getById(@PathVariable String id) {
        return conversionService.convert(practiceService.findById(Integer.parseInt(id)), PracticeViewModel.class);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ResponseBody
    public List<Practice> getAll() {
        return practiceService.findAll();
    }

    @RequestMapping(value = "/getByStudent/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<Event> getByStudentId(@PathVariable String id) {
        List<Practice> list = practiceService.findByStudentId(Integer.parseInt(id));
        List<Event> events = new ArrayList<>();
        for (Practice item : list) {
            HeadOfPractice hop = headOfPracticeService.findById(item.getHopId());
            events.add(new Event(item.getStart(),0,hop.getCompanyName(),hop.getFname()+" "+hop.getLname(),item.getName()));
            events.add(new Event(item.getEnd(),1,hop.getCompanyName(),hop.getFname()+" "+hop.getLname(),item.getName()));
        }
        events.sort(Comparator.comparing(Event::getDate).reversed());
        return events;
    }

    @RequestMapping(value = "/tableForPractice/{id}", method = RequestMethod.GET)
    @ResponseBody
    public TableData returnTable(@PathVariable String id,
                                 @RequestParam(value = "start") String start,
                                 @RequestParam(value = "length") String length,
                                 @RequestParam(value = "draw") String draw,
                                 @RequestParam(value = "search[value]", required = false) String key,
                                 @RequestParam(value = "order[0][column]") String order,
                                 @RequestParam(value = "order[0][dir]") String orderDir) {
        if (key == null) key = "";
        TableData result = new TableData();
        Page<Student> page = studentService.findByParams(Integer.parseInt(id), key, result.getColumnNameForTables(Integer.parseInt(order) - 1), orderDir, Integer.parseInt(start), Integer.parseInt(length));
        List<Student> list = page.getContent();
        result.setRecordsTotal((int) page.getTotalElements() - page.getNumberOfElements());
        result.setRecordsFiltered((int) page.getTotalElements() - page.getNumberOfElements());
        result.setDraw(Integer.parseInt(draw));
        for (Student item: list
                ) {
            result.addData(converter.studentToStringArray(item, true, true, false));
        }
        return result;
    }

    @RequestMapping(value = "/tableForRequest/{facultyId}/{specialityId}", method = RequestMethod.GET)
    @ResponseBody
    public TableData tableForRequest(@PathVariable(value = "facultyId") String facultyId,
                                     @PathVariable(value = "specialityId") String specialityId,
                                     @RequestParam(value = "minavg") String minAvg,
                                     @RequestParam(value = "date") String date,
                                     @RequestParam(value = "budget") String budget,
                                     @RequestParam(value = "start") String start,
                                     @RequestParam(value = "length") String length,
                                     @RequestParam(value = "draw") String draw,
                                     @RequestParam(value = "order[0][column]") String order,
                                     @RequestParam(value = "order[0][dir]") String orderDir) {
        TableData result = new TableData();
        double avg = Double.parseDouble(minAvg);
        String[] dates = date.split(" - ");

        Date startd, end;

        DateFormat format = new SimpleDateFormat("MM/dd/yy", Locale.ENGLISH);
        try {
            startd = format.parse(dates[0]);
            end = format.parse(dates[1]);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
        Page<Student> page = studentService.findForRequest(Integer.parseInt(facultyId), Integer.parseInt(specialityId), startd, end, Integer.parseInt(budget), avg, result.getColumnNameForTables(Integer.parseInt(order) - 1), orderDir, Integer.parseInt(start), Integer.parseInt(length));
        List<Student> list = page.getContent();
        result.setRecordsTotal((int) page.getTotalElements() - page.getNumberOfElements());
        result.setRecordsFiltered((int) page.getTotalElements() - page.getNumberOfElements());
        result.setDraw(Integer.parseInt(draw));
        for (Student item : list
                ) {
            result.addData(converter.studentToStringArray(item, true, false, false));
        }
        return result;
    }

    @RequestMapping(value = "/addRequest/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Practice addPractice(@PathVariable(value = "id") String id,
                                @RequestParam(value = "name") String name,
                                @RequestParam(value = "daterange") String daterange,
                                @RequestParam(value = "faculty") String faculty,
                                @RequestParam(value = "speciality") String speciality,
                                @RequestParam(value = "isBudget", required = false) String isBudget,
                                @RequestParam(value = "minAvg") String minAvg,
                                @RequestParam(value = "checked[]", required = false) String[] checked) {
        //todo validation
        Practice practice = new Practice();
        practice.setName(name);
        practice.setFacultyId(Integer.parseInt(faculty));
        practice.setSpecialityId(Integer.parseInt(speciality));
        if (isBudget != null) practice.setIsBudget(1);
        else practice.setIsBudget(0);
        practice.setMinAvg(Double.parseDouble(minAvg));

        String[] dates = daterange.split(" - ");

        DateFormat format = new SimpleDateFormat("MM/dd/yy", Locale.ENGLISH);
        try {
            Date start = format.parse(dates[0]);
            Date end = format.parse(dates[1]);
            practice.setStart(start);
            practice.setEnd(end);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        practice.setHopId(Integer.parseInt(id));
        Practice result = practiceService.create(practice);
        for (String item : checked) {
            int sid = Integer.parseInt(item.substring(2));
            practiceService.assign(result.getId(), sid);
        }
        return result;
    }

    @RequestMapping(value = "/remove/{id}/{studid}", method = RequestMethod.GET)
    @ResponseBody
    public Student removeFromPractice(@PathVariable(value = "id") String id,
                                      @PathVariable(value = "studid") String studid) {
        if (studentService.findById(Integer.parseInt(studid)) != null)
            return practiceService.removeFromPractice(Integer.parseInt(id), Integer.parseInt(studid));
        return null;
    }

    @RequestMapping(value = "/removeAll/{id}", method = RequestMethod.POST)
    @ResponseBody
    public List<Student> removeAll(@PathVariable(value = "id") String id,
                                   @RequestParam(value = "students[]") String[] students) {
        List<Student> result = new ArrayList<>();
        for (String item : students) {
            int sid = Integer.parseInt(item.substring(2));
            if (studentService.findById(sid) != null)
                result.add(practiceService.removeFromPractice(Integer.parseInt(id), sid));
        }
        return result;
    }

}
