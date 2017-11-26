package com.netcracker.devschool.dev4.studdist.converters;

import com.netcracker.devschool.dev4.studdist.beans.PracticeViewModel;
import com.netcracker.devschool.dev4.studdist.entity.Practice;
import com.netcracker.devschool.dev4.studdist.service.FacultyService;
import com.netcracker.devschool.dev4.studdist.service.SpecialityService;
import com.netcracker.devschool.dev4.studdist.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

@Component
public class PracticeToPracticeViewModelConverter implements Converter<Practice, PracticeViewModel> {

    @Autowired
    FacultyService facultyService;

    @Autowired
    SpecialityService specialityService;

    @Autowired
    StudentService studentService;

    @Override
    public PracticeViewModel convert(Practice practice) {
        PracticeViewModel practiceViewModel = new PracticeViewModel();
        practiceViewModel.setId(practice.getId());
        practiceViewModel.setHopId(practice.getHopId());
        practiceViewModel.setName(practice.getName());
        practiceViewModel.setFaculty(facultyService.findById(practice.getFacultyId()).getName());
        practiceViewModel.setSpeciality(specialityService.findById(
                practice.getSpecialityId()).getName());
        practiceViewModel.setMinAvg(practice.getMinAvg());
        practiceViewModel.setStart(practice.getStart());
        practiceViewModel.setEnd(practice.getEnd());
        practiceViewModel.setIsBudget(practice.getIsBudget());
        practiceViewModel.setNumber((int)
                studentService.findByParams(practice.getId(),
                        "", "id", "desc", 0, 1).getTotalElements());
        return practiceViewModel;
    }
}
