package com.jam.repository.model;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Content {

    private Integer contentId;
    private Integer projectId;
    private String img;

    public String setUpImage() {
        if (img == null) {
            return "https://picsum.photos/id/40/400/400";
        } else {
            return "/images/funding/" + img;
        }
    }
}
