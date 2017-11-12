package com.netcracker.devschool.dev4.studdist.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

public class TableData {
    private int draw;
    private int recordsTotal;
    private int recordsFiltered;
    private List<String[]> data;
    private String searchKey="";

    public TableData() {
        draw = 1;
        recordsTotal = 0;
        recordsFiltered = 0;
        data = new ArrayList<>();
    }

    public void addData(String[] item) {
        if (!Objects.equals(searchKey, "") && !Arrays.toString(item).contains(searchKey)) return;
        if (item!=null) {
            data.add(item);
            recordsTotal++;
            recordsFiltered++;
        }
    }

    public int getDraw() {
        return draw;
    }

    public void setDraw(int draw) {
        this.draw = draw;
    }

    public int getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(int recordsTotal) {
        this.recordsTotal = recordsTotal;
    }

    public int getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(int recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

    public List<String[]> getData() {
        return data;
    }

    public void setSearchKey(String searchKey) {
        this.searchKey = searchKey;
    }

    //ancillary function

    public String getColumnNameForTables(int id) {
        String result;
        switch (id) {
            case 0:
                result = "fname";
                break;
            case 1:
                result = "lname";
                break;
            case 2:
                result = "facultyId";
                break;
            case 3:
                result = "specialityId";
                break;
            case 4:
                result = "group";
                break;
            case 5:
                result = "avgScore";
                break;
            default:
                result = "id";
                break;
        }
        return result;
    }
}
