package com.netcracker.devschool.dev4.studdist.utils;

import java.util.ArrayList;
import java.util.List;

public class TableData {
    private int draw;
    private int recordsTotal;
    private int recordsFiltered;
    private List<String[]> data;

    public TableData() {
        draw = 1;
        recordsTotal = 0;
        recordsFiltered = 0;
        data = new ArrayList<>();
    }

    public void addData(String[] item) {
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
}
