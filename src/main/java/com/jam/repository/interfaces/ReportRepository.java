package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.dto.ReportDTO;
import com.jam.repository.model.Alert;
import com.jam.repository.model.Report;
import com.jam.repository.model.ReportHistory;

@Mapper
public interface ReportRepository {
    
    public List<Report> findAllReports();

    public Report findReportByReportId(@Param("reportId") Integer reportId);

    public void updateReport(@Param("reportId") Integer reportId);
    
    public void insertReportHistory(ReportHistory reportHistory);

    public List<Report> findReportsByPage(@Param("offset") int offset, @Param("size") int size);

    public List<Alert> findAllAlert();
}
