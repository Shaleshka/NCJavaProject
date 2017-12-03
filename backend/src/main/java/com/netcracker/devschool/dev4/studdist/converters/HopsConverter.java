package com.netcracker.devschool.dev4.studdist.converters;

import com.netcracker.devschool.dev4.studdist.entity.HeadOfPractice;
import org.springframework.stereotype.Component;

@Component
public class HopsConverter {

    public String[] hopToStringArray(HeadOfPractice headOfPractice) {
        String[] array = new String[6];
        array[0] = "<label>\n" +
                "                                            <input name=\"isBudget\" class=\"hop_cb" + "\" id=\"hcb" + headOfPractice.getId() + "\" type=\"checkbox\">\n" +
                "                                            \n" +
                "                                        </label>\n";
        array[1] = headOfPractice.getFname();
        array[2] = headOfPractice.getLname();
        array[3] = headOfPractice.getCompanyName();
        array[4] = "<button type=\"button\" class=\"btn btn-primary\" onclick=\"editHop(" + headOfPractice.getId() + ")\">\n" +
                "                                                            Редактировать\n" +
                "                                                        </button>";
        array[5] = "<button type=\"button\" class=\"btn btn-danger\" onclick=\"delHop(" + headOfPractice.getId() + ")\">\n" +
                "                                                            Удалить\n" +
                "                                                        </button>";
        return array;
    }

}
