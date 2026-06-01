package org.example.shroomsanalyzer.dto.xml;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;
import org.example.shroomsanalyzer.entity.AnalysisResult;

import java.util.List;

@JacksonXmlRootElement(localName = "analysisResults")
public class AnalysisListXml {

    @JacksonXmlElementWrapper(useWrapping = false)
    @JacksonXmlProperty(localName = "analysisResult")
    private List<AnalysisResult> items;

    public AnalysisListXml(List<AnalysisResult> items) {
        this.items = items;
    }

    public List<AnalysisResult> getItems() {
        return items;
    }
}
