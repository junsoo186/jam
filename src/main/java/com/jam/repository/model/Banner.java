package com.jam.repository.model;

import com.google.auto.value.AutoValue.Builder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Banner {

    private String title;
    private String content;
    private String subContent;    
    private String imagePath;




    public String setUpBannerImage() {
        return "/images/" + imagePath;
    }
}
  
   