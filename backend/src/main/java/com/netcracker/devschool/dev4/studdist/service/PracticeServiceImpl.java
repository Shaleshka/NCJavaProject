package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Assignment;
import com.netcracker.devschool.dev4.studdist.entity.Practice;
import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.repository.AssignmentRepository;
import com.netcracker.devschool.dev4.studdist.repository.PracticeRepository;
import com.netcracker.devschool.dev4.studdist.repository.StudentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class PracticeServiceImpl implements PracticeService {

    @Resource
    private PracticeRepository practiceRepository;

    @Resource
    private AssignmentRepository assignmentRepository;

    @Resource
    private StudentRepository studentRepository;


    @Override
    @Transactional
    public Practice create(Practice practice) {
        return practiceRepository.save(practice);
    }

    @Override
    @Transactional
    public Practice findById(int id) {
        return practiceRepository.findOne(id);
    }

    @Override
    @Transactional
    public Practice delete(int id) throws Exception {
        Practice deletedPractice = practiceRepository.findOne(id);

        if (deletedPractice!=null) throw new Exception("Not found");

        practiceRepository.delete(id);
        return null;
    }

    @Override
    @Transactional
    public Practice update(Practice practice) {
        Practice updated = practiceRepository.findOne(practice.getId());
        updated.setName(practice.getName());
        updated.setHopId(practice.getHopId());
        updated.setFacultyId(practice.getFacultyId());
        updated.setSpecialityId(practice.getSpecialityId());
        updated.setNumber(practice.getNumber());
        updated.setMinAvg(practice.getMinAvg());
        updated.setStart(practice.getStart());
        updated.setEnd(practice.getEnd());
        return updated;
    }

    @Override
    @Transactional
    public List<Practice> findAll() {
        return practiceRepository.findAll();
    }

    @Override
    @Transactional
    public List<Practice> findByHopId(int id) {
        return practiceRepository.findByHopId(id);
    }

    @Override
    @Transactional
    public List<Practice> findByStudentId(int id) {
        return practiceRepository.findByStudentId(id);
    }

    @Override
    @Transactional
    public Student removeFromPractice(int id, int studentId) {
        assignmentRepository.remove(id, studentId);
        return studentRepository.findOne(studentId);
    }

    @Override
    @Transactional
    public Assignment assign(int id, int studentId) {
        Assignment assignment = new Assignment();
        assignment.setPracticeId(id);
        assignment.setStudentId(studentId);
        return assignmentRepository.save(assignment);
    }
}
