package com.receiver.dataformats;

import com.amazonaws.services.cloudfront.model.InvalidArgumentException;
import com.common.mapreduce.MapperUserModCommand;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.time.Instant;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;


public class ConvertorImplTestCase {

    @Test
    public void testConvertorWithValidInput() throws IOException {
        String input = "2011-12-03T10:15:30+01:00,14,add,generatedlink,closedtab";
        Convertor convertor = new ConvertorImpl();
        String timestamp = "2011-12-03T10:15:30+01:00";
        MapperUserModCommand expected = new MapperUserModCommand(timestamp, "14", "add", new ArrayList<>(Arrays.asList("generatedlink", "closedtab")));
        MapperUserModCommand umc = convertor.convertNexusUMC(input);

        assertEquals(expected, umc);
    }

    @Test(expected = InvalidArgumentException.class)
    public void testConvertorInputWithoutSegmentsList() throws IOException, InvalidArgumentException {
        String input = "2011-12-03T10:15:30+01:00,14,add";
        Convertor convertor = new ConvertorImpl();
        convertor.convertNexusUMC(input);
    }


}
