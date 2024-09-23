package com.jam.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jam.dto.ReportDTO;
import com.jam.repository.interfaces.ReportRepository;
import com.jam.repository.model.Alert;
import com.jam.repository.model.Report;
import com.jam.repository.model.ReportHistory;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReportService {

    private final ReportRepository reportRepository;

    public List<Report> findAllReports() {
        return reportRepository.findAllReports();
    }

    public List<Alert> findAllAlert() {
        return reportRepository.findAllAlert();
    }

    public Report findReportByReportId(Integer reportId) {
        Report report = reportRepository.findReportByReportId(reportId);

        if (report.getPeriodDate() != null && report.getProcessedAt() != null) {
            // 신고 처리된 날짜에 기간을 더해 해제일 계산
            LocalDateTime processedAt = report.getProcessedAt();
            int period = report.getPeriodDate(); // 정지 기간 (일 수)

            if (period > 0) {
                LocalDateTime releaseDateTime = processedAt.plusDays(period);

                // LocalDateTime을 Date로 변환
                Date releaseDate = Date.from(releaseDateTime.atZone(ZoneId.systemDefault()).toInstant());
                report.setReleasedDate(releaseDate);
            } else {
                report.setReleaseDate(null); // 영구 정지는 해제일이 없으므로 null로 설정
            }

            // processedAt도 Date로 변환
            Date processedAtDate = Date.from(processedAt.atZone(ZoneId.systemDefault()).toInstant());
            report.setProcessedAtDate(processedAtDate);
        }
        return report;
    }

    @Transactional
    public void updateReport(Report report, Integer periodDays, Integer adminId, Integer alertId) {

        // 2. 신고 내용을 업데이트
        reportRepository.updateReport(report.getReportId());

        // 3. 신고 이력 테이블에 기록 추가
        ReportHistory reportHistory = new ReportHistory();
        reportHistory.setReportId(report.getReportId()); // 신고 ID
        reportHistory.setUserId(adminId); // 처리 담당자 (관리자 ID)
        reportHistory.setAlertId(alertId); // 선택한 경고 ID
        reportHistory.setPeriodDays(periodDays); // 처리 기간 (일 단위)
        reportHistory.setCreatedAt(Timestamp.valueOf(LocalDateTime.now())); // LocalDateTime을 Timestamp로 변환

        // 4. 신고 이력을 저장
        reportRepository.insertReportHistory(reportHistory);
    }
}
