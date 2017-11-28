*** Settings ***
Documentation    DMHeaderService_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    dmHeaderService
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 46 175 86 156 87 208 104 85 59 64 51 191 171 160 151 219 90 46 20 108 142 194 253 2 215 206 141 103 98 39 236 127 162 202 141 63 213 179 5 89 112 235 26 181 98 234 217 70 79 110 242 130 16 36 133 255 73 77 160 202 56 71 192 205 143 95 173 63 224 213 247 173 243 28 191 167 230 79 92 197 231 139 230 220 96 32 141 115 34 21 6 162 7 9 8 182 92 194 249 186 80 244 22 214 174 108 201 13 41 10 59 137 30 106 68 38 219 42 63 248 189 126 227 188 15 49 7 243 76 252 8 185 233 56 165 187 78 31 6 99 31 238 247 230 56 126 15 243 51 224 85 174 77 32 221 0 72 106 156 162 73 119 24 195 101 229 254 211 105 221 251 169 131 4 161 11 29 189 154 193 83 37 142 145 232 202 165 63 169 88 104 77 43 151 239 246 24 184 179 252 199 243 164 221 118 12 255 215 51 33 207 63 104 87 33 164 186 156 121 93 107 64 40 82 239 2 240 97 50 203 43 164 214 26 101 215 120 153 171 119 183 96 86 52 193 196 161 53 227 31 44 191 9 44 79 248 193 76 180 174 234 212 165 241 27 21 34 231 141 72 9 0 62 247 226 54 89 90 88 196 99 141 82 63 14 180 77 12 220 16 225 2 121 10 185 190 114 236 161 93 227 93 30 203 53 15 3 244 46 178 84 64 24 36 217 137 13 13 195 213 113 42 43 10 65 81 127 159 10 4 57 223 179 211 19 190 176 207 196 200 56 194 193 74 59 211 11 78 6 176 86 108 176 245 107 240 84 203 238 136 101 237 19 125 254 123 212 215 136 165 241 216 251 21 170 33 116 189 141 102 128 125 124 6 119 234 61 146 249 118 135 0 242 72 124 53 75 93 68 75 1 251 129 14 117 73 80 35 12 92 55 244 2 162 154 91 106 178 207 226 213 175 158 176 12 246 149 111 58 28 240 192 179 123 137 115 129 124 146 205 31 250 197 179 232 168 63 191 128 251 180 130 223 198 85 98 234 202 47 75 7 159 27 207 141 177 105 218 52 108 57 130 53 115 173 86 12 41 113 251 86 240 111 57 179 243 143 20 207 96 130 3 56 200 134 17 90 111 148 210 67 128 43 89 161 1 150 179 252 203 239 180 73 197 251 223 4 21 16 120 8 253 90 17 149 121 145 136 60 145 225 183 41 238 84 96 56 237 71 3 149 147 246 146 205 50 245 197 245 211 241 67 249 80 145 102 108 197 60 151 61 35 15 74 133 240 235 212 186 234 165 142 43 202 92 220 99 186 123 208 63 231 30 112 142 217 55 144 56 252 71 191 142 223 17 169 75 213 208 83 52 252 55 149 124 152 169 125 255 205 98 79 183 234 105 178 75 242 235 10 201 209 149 41 15 181 102 1 191 241 117 0 147 153 58 255 142 13 178 141 107 218 93 165 11 69 50 20 94 92 170 76 170 194 18 160 242 76 106 69 21 132 31 92 0 185 46 132 14 223 39 43 170 147 62 195 170 59 37 227 88 31 226 130 99 153 73 25 183 104 191 212 218 47 171 219 131 73 18 194 222 232 133 13 178 149 86 13 183 0 47 251 69 227 252 42 232 188 48 218 149 196 172 64 109 229 32 235 173 78 202 181 78 225 250 138 145 250 215 241 212 214 9 37 19 146 162 192 176 93 170 30 246 228 201 151 68 245 238 69 199 0 127 244 247 168 156 55 188 138 155 203 158 196 96 239 6 176 104 127 68 172 74 237 5 236 50 6 14 3 62 138 12 23 158 125 248 156 93 94 154 119 120 51 86 115 114 35 153 192 118 131 115 8 81 201 27 131 53 45 7 56 198 176 242 172 234 42 44 242 73 200 211 98 129 214 134 178 144 241 6 187 239 119 2 5 151 17 177 48 8 58 148 218 43 39 36 68 223 148 138 56 176 77 133 94 227 39 27 92 73 194 146 186 74 172 81 67 106 231 254 74 202 186 92 162 150 242 253 81 188 194 101 65 11 1 54 93 236 149 250 98 247 161 136 234 57 143 228 2 167 6 61 55 5 131 47 217 80 198 42 241 37 186 205 188 18 146 246 201 29 161 140 11 92 31 117 161 212 49 107 140 246 36 108 1 188 26 37 124 178 107 240 40 198 159 34 106 44 212 36 15 135 64 137 8 45 127 81 58 85 131 192 228 43 34 58 224 45 146 142 190 198 22 14 4 17 122 81 235 170 166 197 15 235 174 109 230 80 245 1282493031
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] dmHeaderService::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
