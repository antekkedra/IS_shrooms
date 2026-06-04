package org.example.shroomsanalyzer.dto.xml;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;
import org.example.shroomsanalyzer.entity.SoilData;

import java.util.List;

@JacksonXmlRootElement(localName = "soilDataList")
public class SoilListXml {

    @JacksonXmlElementWrapper(useWrapping = false)
    @JacksonXmlProperty(localName = "soilData")
    private List<SoilData> items;

    public SoilListXml(List<SoilData> items) {
        this.items = items;
    }

    public List<SoilData> getItems() {
        return items;
    }
}
