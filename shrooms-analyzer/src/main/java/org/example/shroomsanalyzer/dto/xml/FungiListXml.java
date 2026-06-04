package org.example.shroomsanalyzer.dto.xml;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;
import org.example.shroomsanalyzer.entity.FungiOccurrence;

import java.util.List;

@JacksonXmlRootElement(localName = "fungiOccurrences")
public class FungiListXml {

    @JacksonXmlElementWrapper(useWrapping = false)
    @JacksonXmlProperty(localName = "fungiOccurrence")
    private List<FungiOccurrence> items;

    public FungiListXml(List<FungiOccurrence> items) {
        this.items = items;
    }

    public List<FungiOccurrence> getItems() {
        return items;
    }
}
